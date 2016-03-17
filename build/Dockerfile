FROM base/archlinux
COPY hyperkube /hyperkube
COPY kubectl /kubectl
RUN chmod u+x /hyperkube
RUN chmod u+x /kubectl
CMD ["/kubectl"]

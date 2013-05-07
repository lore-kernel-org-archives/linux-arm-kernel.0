From: rob@landley.net (Rob Landley)
Date: Tue, 07 May 2013 00:02:13 -0500
Subject: [PATCH V2 2/3] Documentation: virtio: Add emergency write
 (emerg_wr) config register in virtio console.
In-Reply-To: <1367842791-30285-3-git-send-email-pranavkumar@linaro.org>
 (from pranavkumar@linaro.org on Mon May  6 07:19:50 2013)
References: <1367842791-30285-1-git-send-email-pranavkumar@linaro.org>
 <1367842791-30285-3-git-send-email-pranavkumar@linaro.org>
Message-ID: <1367902933.18069.212@driftwood>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/06/2013 07:19:50 AM, Pranavkumar Sawargaonkar wrote:
> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
> Signed-off-by: Anup Patel <anup.patel@linaro.org>
> ---
>  Documentation/virtual/virtio-spec.txt |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/virtual/virtio-spec.txt  
> b/Documentation/virtual/virtio-spec.txt
> index 0d6ec85..3ca38f8 100644
> --- a/Documentation/virtual/virtio-spec.txt
> +++ b/Documentation/virtual/virtio-spec.txt
> @@ -1927,11 +1927,16 @@ Ports 2 onwards only if  
> VIRTIO_CONSOLE_F_MULTIPORT is set
>      ports; configuration fields nr_ports and max_nr_ports are
>      valid and control virtqueues will be used.
> 
> +  VIRTIO_CONSOLE_F_EMERG_WRITE(2) Device has support for emergency
> +  write. Configuration filed emerg_wr is valid.

Emergency?

Really?

Out of morbid curiosity, what would constitute an _emergency_ in a  
virtual machine logging context?

Rob

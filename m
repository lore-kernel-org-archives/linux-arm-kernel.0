From: pushkar.iit@gmail.com (Pushkar Jambhlekar)
Date: Thu, 16 Mar 2017 11:01:38 +0530
Subject: [PATCH] vc04_services: Fixing coding guideline error
In-Reply-To: <1489559468-46932-1-git-send-email-pushkar.iit@gmail.com>
References: <1489559468-46932-1-git-send-email-pushkar.iit@gmail.com>
Message-ID: <CAMvNc9BT7_5Hu2iFxd1cbEY64jzQxCEZhdgU8cm_p_SDnZFZhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Any comment?

On Wed, Mar 15, 2017 at 12:01 PM, Pushkar Jambhlekar
<pushkar.iit@gmail.com> wrote:
> Fixing 'if' block coding style. '{' should follow 'if' for multiline block
>
> Signed-off-by: Pushkar Jambhlekar <pushkar.iit@gmail.com>
> ---
>  drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
> index 48984ab..ca896a5 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
> @@ -797,8 +797,7 @@ int32_t vchi_get_peer_version(const VCHI_SERVICE_HANDLE_T handle, short *peer_ve
>  {
>         int32_t ret = -1;
>         SHIM_SERVICE_T *service = (SHIM_SERVICE_T *)handle;
> -       if (service)
> -       {
> +       if (service) {
>                 VCHIQ_STATUS_T status;
>
>                 status = vchiq_get_peer_version(service->handle, peer_version);
> --
> 2.7.4
>



-- 
Jambhlekar Pushkar Arun
M.Tech IIT Roorkee

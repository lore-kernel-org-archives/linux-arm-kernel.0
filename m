From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 25 May 2010 13:29:46 +0400
Subject: [PATCH 1/2] ARM: SAMSUNG: MMC: Fix build error when both DMA
	and	PIO mode selected
In-Reply-To: <4BFB2443.1040701@vscht.cz>
References: <4BFB2443.1040701@vscht.cz>
Message-ID: <4BFB988A.1080100@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Pinkava J. wrote:

> Signed-off-by: Jiri Pinkava <jiri.pinkava@vscht.cz>
> ---
>  drivers/mmc/host/s3cmci.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

> diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
> index 2fdf768..4426a4b 100644
> --- a/drivers/mmc/host/s3cmci.c
> +++ b/drivers/mmc/host/s3cmci.c
> @@ -1600,7 +1600,7 @@ static int __devinit s3cmci_probe(struct platform_device
> *pdev)

    Your patch is line wrapped. Should be easy to fix however...

WBR, Sergei

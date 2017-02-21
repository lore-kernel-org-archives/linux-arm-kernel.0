From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 21 Feb 2017 11:25:01 +0200
Subject: [PATCH v3 7/7] ARM: dts: bcm2837: add &sdhci and &sdhost
In-Reply-To: <1487668026-7100-8-git-send-email-kraxel@redhat.com>
References: <1487668026-7100-1-git-send-email-kraxel@redhat.com>
 <1487668026-7100-8-git-send-email-kraxel@redhat.com>
Message-ID: <20170221092501.mgov6icwxsobdeqt@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gerd,

On Tue, Feb 21, 2017 at 10:07:06AM +0100, Gerd Hoffmann wrote:
> For the raspberry pi 3 we'll need both sdhci (handles sdio wifi) and
> sdhost (handles sdcard).
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Acked-by: Eric Anholt <eric@anholt.net>
> ---
>  arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

Subject prefix should be 'arm64:'.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -

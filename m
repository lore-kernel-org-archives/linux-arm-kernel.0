From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 29 May 2012 09:57:39 -0300
Subject: [PATCH] MXS: Add DENX M28 dts file
In-Reply-To: <201205281830.23380.marex@denx.de>
References: <1338084735-12083-1-git-send-email-marex@denx.de>
 <CAOMZO5C-XbGqWHxpX24V6X58rcnSeSobuyJNiZTJErQi55tEbQ@mail.gmail.com>
 <201205281830.23380.marex@denx.de>
Message-ID: <CAOMZO5DF+ov=qUB6JrD_LvQf7eb5wdswHJV4-vLJPeYG88DaVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 28, 2012 at 1:30 PM, Marek Vasut <marex@denx.de> wrote:

>> Shouldn't this be:
>>
>> sound {
>> ? ? ? compatible = "fsl,imx28-m28-sgtl5000",
>> ? ? ? ? ? ? ? ? ? ?"fsl,mxs-audio-sgtl5000";
>
> Wait, no ... it should not, why should it? (I'm still very lame with this device
> tree stuff, so any advice is very welcome)

My understanding is that you need to reference your machine name in
the compatible field instead of referencing another one (mx28evk).
Maybe someone else can confirm this.

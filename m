From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 28 Apr 2010 08:33:09 -0400
Subject: [02/10] mmp: enable L2 in mmp2
In-Reply-To: <t2of17812d71004280523sf8cd87aen8baa1762b0d1049a@mail.gmail.com>
References: <z2m771cded01004280518ge227275h923782cecd738993@mail.gmail.com>
	<t2of17812d71004280523sf8cd87aen8baa1762b0d1049a@mail.gmail.com>
Message-ID: <r2o771cded01004280533xdfbb4366q35350425ac73b348@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 28, 2010 at 8:23 AM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Wed, Apr 28, 2010 at 8:18 PM, Haojian Zhuang
> <haojian.zhuang@gmail.com> wrote:
>> ?config CACHE_TAUROS2
>> ? ? ? ?bool "Enable the Tauros2 L2 cache controller"
>> - ? ? ? depends on ARCH_DOVE
>> - ? ? ? default y
>> + ? ? ? depends on (ARCH_DOVE || ARCH_MMP)
>> + ? ? ? default n
>
> This also affects Dove by making default to 'n'. Is there any specific reason
> that MMP2 doesn't turn L2 on by default?
>

Yes, you're right. It's my typo error. Now fix it in the attachment.

Thanks
Haojian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002--ARM-mmp-enable-L2-in-mmp2.patch
Type: text/x-patch
Size: 2018 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100428/2094bb56/attachment.bin>

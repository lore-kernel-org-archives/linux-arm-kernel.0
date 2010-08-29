From: jayakumar.lkml@gmail.com (Jaya Kumar)
Date: Sun, 29 Aug 2010 13:08:23 +0800
Subject: pxa168 and LINUX_REBOOT_CMD_POWER_OFF
In-Reply-To: <AANLkTikn_0=w07d=zkPk0nn4r7m6jzBKGaMKkc4dKdmQ@mail.gmail.com>
References: <AANLkTikdGoVwo6igAzf2xtPDvM3adwkfG_X-3AtKN=fU@mail.gmail.com>
	<AANLkTikdxhpwF637joeyRcbNd1CuU4-pKh6EPETDw1_v@mail.gmail.com>
	<AANLkTikn_0=w07d=zkPk0nn4r7m6jzBKGaMKkc4dKdmQ@mail.gmail.com>
Message-ID: <AANLkTinu8pN4oc324t2ND1RTwfF3p1brWiM8QjgDqos6@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 22, 2010 at 11:01 PM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
>
> There's all eight power domains can be controlled by max8660. V1~V5 is
> controlled by SYS_EN signal. V6 & V7 is controlled by I2C bus. V8 is
> VCC_BBATT domain that should be always ON. So we can't shutdown all
> power on Aspenite since V8 shoudl be always ON.
>
> So the key is SYS_EN. In Aspenite board, one signal of GPIO expander
> is named EXP2_SYS_DIS_N. If we put this signal to low, the SYS_EN
> signal will do a negative transition.

Thanks Haojian, Eric, Marek. That was useful info.

Regards,
jaya

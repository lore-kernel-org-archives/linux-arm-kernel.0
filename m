From: otavio@ossystems.com.br (Otavio Salvador)
Date: Tue, 16 Jul 2013 09:24:10 -0300
Subject: [PATCH 1/5] ARM: dts: imx23-evk: enable USB PHY and controller
In-Reply-To: <CAOMZO5D+szAgY6+CHjwFRw2qwvusv2_Ach0hv=hj4X1cmMnHfA@mail.gmail.com>
References: <1373898160-8460-1-git-send-email-otavio@ossystems.com.br>
 <CAOMZO5D+szAgY6+CHjwFRw2qwvusv2_Ach0hv=hj4X1cmMnHfA@mail.gmail.com>
Message-ID: <CAP9ODKpByXLm1xkbfxJoktYr2ZNSD1cwNmtV95pfnjQ0jgeWYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 16, 2013 at 12:42 AM, Fabio Estevam <festevam@gmail.com> wrote:
> On Mon, Jul 15, 2013 at 11:22 AM, Otavio Salvador
> <otavio@ossystems.com.br> wrote:
>> The i.MX23EVK board provides a USB port so the USB PHY and controller
>> need to be enabled for it to be usable.
>
> Has this been tested? I don't see in this patch any code to enable USB power.

It does, I am using it.

--
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://projetos.ossystems.com.br
Mobile: +55 (53) 9981-7854            Mobile: +1 (347) 903-9750

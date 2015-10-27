From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 27 Oct 2015 14:53:44 -0200
Subject: iMX6 SSI in TDM master mode and SDMA
In-Reply-To: <3531856.xGOeYJXuNb@adelgunde>
References: <562F8DF7.2000704@tekno-soft.it>
	<3531856.xGOeYJXuNb@adelgunde>
Message-ID: <CAOMZO5CzEbXAmWpfd-JrpoP5OJ6HAioTPWF7nvKcX=BRf1Dngg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Roberto,

On Tue, Oct 27, 2015 at 1:20 PM, Markus Pargmann <mpa@pengutronix.de> wrote:
> Hi,
>
> On Tuesday 27 October 2015 15:45:11 Roberto Fichera wrote:
>> Hi There,
>>
>> I'm having an SDMA freeze when putting the SSI in TDM master mode while
>> developing a DAHDI kernel driver. Kernel is the official freescale v3.14.28.
>
> Please use the mainline kernel. fsl-ssi has really good mainline support. I
> don't think anyone can help you with such an old kernel.

Also, this one could be better discussed in the alsa-devel mailing list.

Caleb is also trying to use SSI in TDM mode (See his post in
alsa-devel archive), so maybe you two could work together on this
task.

Regards,

Fabio Estevam

From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Thu, 19 Jan 2012 08:06:28 +0100
Subject: imx53
In-Reply-To: <1326925172.3468.300.camel@hp-dhlii>
References: <4F16E7B9.7050307@dlasys.net>
 <CAOMZO5Aqws0Ow1DxHnJ4XYfAO-zsgOuLwJueRUCBt53g1kN0bQ@mail.gmail.com>
 <1326925172.3468.300.camel@hp-dhlii>
Message-ID: <4F17C0F4.3090703@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18.01.2012 23:19, David Lynch Jr. wrote:
> Linus's tree does not yet include numerous imx53 drivers. 
> While I can get it to boot, there is lots of hardware that does not
> work. 
> 
> Freescale and others are doing imx53 driver work and most drivers are
> available somewhere, though I have not found them all in the same place.
> 
> Regardless, I am just looking for an appropriate reference/starting
> point. 

You might want to have a look to Linaro, too. E.g.

http://git.linaro.org/gitweb?p=bsp/freescale/linux-linaro.git;a=shortlog;h=refs/heads/lt-3.2-imx5

If I understood correctly, from Freescale point of view, the Linaro 
Freescale landing team is responsible to mainline the Freescale work.

Best regards

Dirk

> What would be the normal route for i.MX53 work into the kernel ?
> 
> I can pull that, start there, merge what I need and submit patches if no
> one else does.  
> 
> 
> 
> On Wed, 2012-01-18 at 17:57 -0200, Fabio Estevam wrote:
>> On Wed, Jan 18, 2012 at 1:39 PM, David H. Lynch Jr. <dhlii@dlasys.net> wrote:
>>> Where would I look for the appropriate git kernel source tree that is being
>>> used for i.MX53 development feeding the distribution kernel ?
>> You can use Linus' tree directly.
>>
>> Regards,
>>
>> Fabio Estevam

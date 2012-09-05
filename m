From: gcembed@gmail.com (=?UTF-8?B?R2HDq3RhbiBDYXJsaWVy?=)
Date: Wed, 05 Sep 2012 17:03:43 +0200
Subject: [PATCH] ARM : i.MX27 : split code for allocation of ressources
 of camera and eMMA
In-Reply-To: <CAOMZO5D7DrUwg1YYwPnXgMj4nsgS=2ctnb7J3n-60hkreoP3yw@mail.gmail.com>
References: <1346763398-13536-1-git-send-email-gcembed@gmail.com>
 <CACKLOr0PO1jbxrfRoEwEAGFNkNkAFUA-oB2vLZpw1kDxEYPBQw@mail.gmail.com>
 <5047013E.30508@gmail.com>
 <CACKLOr1RipM3QVJBaTjXHFotqSMdrCsWLkBsgiiuauTWpxR6EQ@mail.gmail.com>
 <50471187.3040809@gmail.com>
 <CACKLOr0=TccMNoQV-LfkeBrCN5=0E8eqTEaT7PRk-KAv_mQ5RQ@mail.gmail.com>
 <50471CEE.60606@gmail.com>
 <CAOMZO5D7DrUwg1YYwPnXgMj4nsgS=2ctnb7J3n-60hkreoP3yw@mail.gmail.com>
Message-ID: <504769CF.2070904@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/05/2012 03:47 PM, Fabio Estevam wrote:
> Javier/Ga?tan,
>
> On Wed, Sep 5, 2012 at 6:35 AM, Ga?tan Carlier <gcembed@gmail.com> wrote:
>
>> When I apply the patch (I save my mail and apply it), there is no
>> conflict/reject. Tested on linux-next-20120824 and linux-next-20120905.
>
> Can you please confirm whether you are able to run mx2_camera on
> linux-next-20120905?
With or without my patch ? I have burnt out my ov2640 while previous 
experimentation so it is hard for me to test that and I have to write 
driver for MT9V111 to be able to test soc-camera on Kernel 3.x.
>
> Tried it on my mx27pdk (and mx31pdk also) and the ov2640 is not detected.
>
> Regards,
>
> Fabio Estevam
>
Regards,
Ga?tan Carlier

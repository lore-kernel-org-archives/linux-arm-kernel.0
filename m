From: ivo.g.dimitrov.75@gmail.com (Ivaylo Dimitrov)
Date: Sat, 30 Apr 2016 01:47:57 +0300
Subject: camera application for testing (was Re: v4l subdevs without big
 device)
In-Reply-To: <201604300020.58559@pali>
References: <20160428084546.GA9957@amd> <57230DE7.3020701@xs4all.nl>
 <20160429221359.GA29297@amd> <201604300020.58559@pali>
Message-ID: <5723E49D.1030104@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 30.04.2016 01:20, Pali Roh?r wrote:
> On Saturday 30 April 2016 00:13:59 Pavel Machek wrote:
>> Any other application I should look at? Thanks,
>
> Maybe camera-ui, which is part of CSSU?
>
> https://github.com/community-ssu/camera-ui
>

This is based on gdigicam, are you sure it is compatible with recent 
kernel/userspace? Also, iirc gdigicam needs omap3camd working, but we 
still don't have the needed compat layer.

Ivo

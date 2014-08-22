From: holler@ahsoftware.de (Alexander Holler)
Date: Fri, 22 Aug 2014 17:45:01 +0200
Subject: [RFC PATCH 0/9] dt: dependencies (for deterministic driver
 initialization order based on the DT)
In-Reply-To: <20140822131919.GX21734@leverpostej>
References: <1399913280-6915-1-git-send-email-holler@ahsoftware.de>
 <20140514141914.446F7C4153D@trevor.secretlab.ca>
 <20140821140211.GD19293@ulmo.nvidia.com> <53F64624.5000403@ahsoftware.de>
 <20140822131919.GX21734@leverpostej>
Message-ID: <53F7657D.2060304@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 22.08.2014 15:19, schrieb Mark Rutland:
> On Thu, Aug 21, 2014 at 08:19:00PM +0100, Alexander Holler wrote:
>> Am 21.08.2014 16:02, schrieb Thierry Reding:
>>
>>> Anyway, those are all fairly standard reasons for where deferred probe
>>> triggers, and since I do like deferred probe for it's simplicity and
>>> reliability I'd rather not try to work around it if boot time is all
>>> that people are concerned about.
>>
>> It's neither simple nor reliable. It's non deterministic brutforcing
>> while making it almost impossible to identify real errors.
>
> It's horrible, yes.
>
>> In my humble opinion the worst way to solve something. I'm pretty sure
>> if I would have suggest such a solution, the maintainer crowd would have
>> eaten me without cooking.
>
> We didn't have a better workable solution at the time. Having a hack
> that got boards booting was considered better than not having them boot.
> I don't remember people being particularly enthralled by the idea.

Agreed. And usually I don't flame about workarounds. They are needed 
practice usually born out of a time limited background or similiar 
constraints.

Only Linux kernel maintainers do demand perfect stuff from others as the 
kernel seems to have to be a perfect school project. I for myself 
already think checkpatch is a ridiculous tool, only invented to drive 
people crazy. Of course, it's better a tool drives people crazy than a 
maintainer who make decisions based on the phase of the moon, but ... ;)

And I haven't flamed much about deferred probe before, but if I read 
it's simple and reliable I couldn't stand still.

Sorry,

Alexander Holler

From: mchehab@redhat.com (Mauro Carvalho Chehab)
Date: Thu, 24 Nov 2011 18:06:01 -0200
Subject: [PATCH RESEND] davinci: dm646x: move vpif related code to driver
 core header from platform
In-Reply-To: <DF0F476B391FA8409C78302C7BA518B602DDD6@DBDE01.ent.ti.com>
References: <1321110362-6699-1-git-send-email-manjunath.hadli@ti.com>
 <4ECE8764.60800@redhat.com>
 <DF0F476B391FA8409C78302C7BA518B602DDD6@DBDE01.ent.ti.com>
Message-ID: <4ECEA3A9.1080506@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em 24-11-2011 16:22, Nori, Sekhar escreveu:
> Hi Mauro,
> 
> On Thu, Nov 24, 2011 at 23:35:24, Mauro Carvalho Chehab wrote:
>> Em 12-11-2011 13:06, Manjunath Hadli escreveu:
>>> move vpif related code for capture and display drivers
>>> from dm646x platform header file to vpif_types.h as these definitions
>>> are related to driver code more than the platform or board.
>>>
>>> Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>
>>
>> Manju,
>>
>> Why are you re-sending a patch?
>>
>> My understanding is that you're maintaining the davinci patches, so it is
>> up to you to put those patches on your tree and send me a pull request when
>> they're done. So, please, don't pollute the ML re-sending emails that
>> are for yourself to handle.
> 
> Since this particular patch touches arch/arm/mach-davinci
> as well as drivers/media/video, the plan was to queue the
> patch through ARM tree with your Ack. We did not get your
> ack the last time around[1] so it was resent.
> 
> Do let me know if your ack is not needed.
> 
> Thanks,
> Sekhar
> 
> [1] http://www.mail-archive.com/davinci-linux-open-source at linux.davincidsp.com/msg21840.html

Hmm.. I missed this email, but just re-sending it without request my ACK doesn't help
much ;)

If this ever happens again, next time the better is to forward me the patch again, on
an email asking for my ack.

With regards to the patch:

Acked-by: Mauro Carvalho Chehab <mchehab@redhat.com>

Regards,
Mauro

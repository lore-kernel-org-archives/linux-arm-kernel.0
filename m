From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 17 Sep 2016 12:12:04 +0200
Subject: [PATCH] musb: Export musb_root_disconnect for use in modules
In-Reply-To: <20160916155608.GA31257@kroah.com>
References: <20160916145936.3297-1-hdegoede@redhat.com>
 <20160916154701.GA20742@kroah.com> <20160916155317.GE27974@sirena.org.uk>
 <20160916155608.GA31257@kroah.com>
Message-ID: <9e474920-2ebd-8d38-7c7b-d8e894dc2568@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 16-09-16 17:56, Greg Kroah-Hartman wrote:
> On Fri, Sep 16, 2016 at 04:53:17PM +0100, Mark Brown wrote:
>> On Fri, Sep 16, 2016 at 05:47:01PM +0200, Greg Kroah-Hartman wrote:
>>> On Fri, Sep 16, 2016 at 04:59:36PM +0200, Hans de Goede wrote:
>>
>>>> +EXPORT_SYMBOL_GPL(musb_root_disconnect);
>>
>>> Does this fix a build error somehow?  Who reported it?
>>
>> Yes, the sunxi driver uses this symbol and the build bots reported it
>> yesterday.
>
> then all of that should have been in this patch :(
>
> So much for me trying to be subtle...

Sorry, you're right, I'll add a Fixes tag, and I'll mention
this fixes a buildbot reported error too.

I'll do a v2 with this right away.

For the next time, is there any official format to
mention the buildbot report or some such ?

Regards,

Hans

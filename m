From: robherring2@gmail.com (Rob Herring)
Date: Thu, 25 Jul 2013 15:16:14 -0500
Subject: DT bindings as ABI [was: Do we have people interested in device
 tree janitoring / cleanup?]
In-Reply-To: <20130725193135.GT23879@titan.lakedaemon.net>
References: <CAOesGMhJ+je8FZqeFxhAcYwU0CHYer+aGP6DA_8x3azrzfA2sw@mail.gmail.com>
 <CAL_JsqJQWOLC9f1igEpsgJB2X8mFDpqLDaFFRjGGVHctjWZLgQ@mail.gmail.com>
 <20130725193135.GT23879@titan.lakedaemon.net>
Message-ID: <CAL_Jsq+vWbTb8wNEDCR2c_M6sBnKW6e5HGk48QzmXSujQUdddA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 25, 2013 at 2:31 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> On Thu, Jul 25, 2013 at 02:11:31PM -0500, Rob Herring wrote:
>> On Thu, Jul 25, 2013 at 11:09 AM, Olof Johansson <olof@lixom.net> wrote:
>
>> > One problem that needs to be solved is obviously how a binding
>> > graduates from tentative to locked. This work isn't going to be very
>> > interesting to most people, I suspect. Think standards committee type
>> > work.
>>
>> I think a time based stabilization period would be better than a
>> separate directory to apply bindings too. Or time plus periodic review
>> perhaps.
>
> The only problem with a time-based versus separate directory is how do
> users who've downloaded the tree determine which bindings are stable?
> If they pull a tarball, or receive an SDK, there is most likely no git
> history attached.

Well, if time based includes moving the binding out of the kernel,
then that is what defines it as stable or not. I guess that is a form
of a separate directory. I don't think we want to be moving bindings
twice: tentative -> stable and kernel -> DT repo.

The policy could be as simple as an binding without change in at least
N kernel releases is moved out and stable.

Rob

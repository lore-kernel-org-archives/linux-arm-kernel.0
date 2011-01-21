From: dmitriyz@google.com (Dima Zavin)
Date: Thu, 20 Jan 2011 18:13:31 -0800
Subject: [PATCH 0/7] Nexus One Support
In-Reply-To: <1295575123.9236.54.camel@m0nster>
References: <1295555565-21563-1-git-send-email-dwalker@codeaurora.org>
	<AANLkTik+HCj9dkD2s4WgwCqKWCXDbdSnKDUbyGfYfaPr@mail.gmail.com>
	<1295571359.9236.53.camel@m0nster>
	<1295574085.4096.6.camel@Joe-Laptop>
	<1295575123.9236.54.camel@m0nster>
Message-ID: <AANLkTikH=jj8G2tJ88HOW82gUxAouk6mbYz2txF73Fsf@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

You did not write ANY code for the mahimahi (Nexus One) board. You
took patches from the android.git.kernel.org git server, squashed some
together, and then slapped your name on them as the author. I
appreciate your effort to send this code upstream and do whatever
minor cleanups, but I still maintain that you are not the author of
this code.

--Dima

On Thu, Jan 20, 2011 at 5:58 PM, Daniel Walker <dwalker@codeaurora.org> wrote:
> On Thu, 2011-01-20 at 17:41 -0800, Joe Perches wrote:
>> On Thu, 2011-01-20 at 16:55 -0800, Daniel Walker wrote:
>> > On Thu, 2011-01-20 at 16:42 -0800, Dima Zavin wrote:
>> > > You are not the author of any of these patches. Where are the author
>> > > attributions for the team that actually wrote this code?
>> > In the commit text.. The author field is used to denote who authored the
>> > commit, which in this case is me.
>>
>> You have that wrong.
>> Author and Committer are different git fields.
>>
>> http://www.kernel.org/pub/software/scm/git/docs/user-manual.html
>>
>> ? ? ? * an author: The name of the person responsible for this change,
>> ? ? ? ? together with its date.
>> ? ? ? * a committer: The name of the person who actually created the
>> ? ? ? ? commit, with the date it was done. This may be different from
>> ? ? ? ? the author, for example, if the author was someone who wrote a
>> ? ? ? ? patch and emailed it to the person who used it to create the
>> ? ? ? ? commit.
>
>
> I'm not even sure how to make these different, but in this case it
> doesn't matter because the "committer" as you defined it above is more
> than one person ..
>
> Daniel
>
> --
> Sent by an consultant of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
> Forum.
>
>
>

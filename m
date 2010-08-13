From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Fri, 13 Aug 2010 03:01:17 +0300
Subject: [PATCH v4 3/8] wireless: wl1271: add platform driver to get board
	data
In-Reply-To: <20100812095546.GA3354@n2100.arm.linux.org.uk>
References: <1281550913-17633-1-git-send-email-ohad@wizery.com>
	<1281550913-17633-4-git-send-email-ohad@wizery.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0324110ABD@dbde02.ent.ti.com>
	<20100811184742.GA21778@nokia.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0324110AC1@dbde02.ent.ti.com>
	<20100811185724.GD21778@nokia.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0324110AC7@dbde02.ent.ti.com>
	<20100811212513.GC827@n2100.arm.linux.org.uk>
	<AANLkTikDhzGVFZhNJZic9xYX9bL_NhOW=4LS-cTFSG0i@mail.gmail.com>
	<20100812095546.GA3354@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=f_vghwQZn3HHs_CJKYiMf_pp85JHujsyvRg3J@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, August 12, 2010, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Aug 12, 2010 at 09:40:19AM +0300, Ohad Ben-Cohen wrote:
>> On Thu, Aug 12, 2010 at 12:25 AM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> >I've outlined a far simpler and easiler solution
>> > which avoids this kind of abuse, and given suggestions on how to extend
>> > it to support multiple instances.
>> >
>>
>> Do you mean:
>> http://www.spinics.net/lists/arm-kernel/msg95338.html
>> ?
>>
>> I was under the impression you eventually discarded that approach in
>> that post.
>
> Indeed.
>
> I'm talking about my first suggestion:
>
> http://lists.arm.linux.org.uk/lurker/message/20100804.114148.bf961e83.en.html
>
> which was later expanded by Vitaly:
>
> http://lists.arm.linux.org.uk/lurker/message/20100804.140119.f476c29c.en.html
>
> I don't think anyone had any negative comments against that proposal.

Thanks, I see what you mean now.

I'll give this a spin when I'm back (I'm away until e/o August)
>

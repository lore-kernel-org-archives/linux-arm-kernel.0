From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Aug 2010 10:55:46 +0100
Subject: [PATCH v4 3/8] wireless: wl1271: add platform driver to get
	board data
In-Reply-To: <AANLkTikDhzGVFZhNJZic9xYX9bL_NhOW=4LS-cTFSG0i@mail.gmail.com>
References: <1281550913-17633-1-git-send-email-ohad@wizery.com>
	<1281550913-17633-4-git-send-email-ohad@wizery.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0324110ABD@dbde02.ent.ti.com>
	<20100811184742.GA21778@nokia.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0324110AC1@dbde02.ent.ti.com>
	<20100811185724.GD21778@nokia.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0324110AC7@dbde02.ent.ti.com>
	<20100811212513.GC827@n2100.arm.linux.org.uk>
	<AANLkTikDhzGVFZhNJZic9xYX9bL_NhOW=4LS-cTFSG0i@mail.gmail.com>
Message-ID: <20100812095546.GA3354@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 12, 2010 at 09:40:19AM +0300, Ohad Ben-Cohen wrote:
> On Thu, Aug 12, 2010 at 12:25 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> >I've outlined a far simpler and easiler solution
> > which avoids this kind of abuse, and given suggestions on how to extend
> > it to support multiple instances.
> >
> 
> Do you mean:
> http://www.spinics.net/lists/arm-kernel/msg95338.html
> ?
> 
> I was under the impression you eventually discarded that approach in
> that post.

Indeed.

I'm talking about my first suggestion:

http://lists.arm.linux.org.uk/lurker/message/20100804.114148.bf961e83.en.html

which was later expanded by Vitaly:

http://lists.arm.linux.org.uk/lurker/message/20100804.140119.f476c29c.en.html

I don't think anyone had any negative comments against that proposal.

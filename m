From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 25 Mar 2011 20:05:57 +0000
Subject: [PATCH] OMAP: iovmm: fix SW flags passed by user
In-Reply-To: <AANLkTikV37gmmf5sRQ98EzOL6K7JNvDy9gfCWbR=747k@mail.gmail.com>
References: <1301071572-25251-1-git-send-email-omar.ramirez@ti.com>
	<4D8CD126.6000405@ru.mvista.com>
	<AANLkTikV37gmmf5sRQ98EzOL6K7JNvDy9gfCWbR=747k@mail.gmail.com>
Message-ID: <20110325200557.GA14228@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 25, 2011 at 12:36:57PM -0500, Ramirez Luna, Omar wrote:
> On Fri, Mar 25, 2011 at 12:30 PM, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
> > Hello.
> >
> > Omar Ramirez Luna wrote:
> >
> >> Commit d038aee24dcd changes iovmm to receive flags specified by user,
> >
> > ? Please also specify that commit's summary for the human readers. Bare ID
> > is only usable to gitweb...
> 
> Here it is the patch, introducing the change:
> 
> https://patchwork.kernel.org/patch/620871/
> 
> If accepted by Hiroshi, I can update the description making reference
> to this patch instead of commit.

It is a requirement that all descriptions which refer to a commit shall
contain both the commit ID *and* the summary line for that commit.
Failure to ensure that's the case results in rejection of the patch
until it conforms.

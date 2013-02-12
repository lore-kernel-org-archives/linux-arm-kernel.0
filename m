From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Feb 2013 17:13:10 +0000
Subject: ARM big-endian on current kernels for linux-3.8
In-Reply-To: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20130212171310.GS17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 08, 2013 at 11:17:30PM +0000, Ben Dooks wrote:
> I have been working on getting big-endian kernels working, mainly from
> little-endian boot envrionments. The following patch series is what I
> have been working on, mainly on the highbank and axp systems.

What is missing from this is the justification about why we need this
additional pain, given that all the supporting userspaces today are all
LE based.

Sure, I know that telcos have an endless love of big endian and don't
understand anything else, but getting this working on non-telco socs
seems to be a little odd.

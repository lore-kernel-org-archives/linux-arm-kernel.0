From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 29 Jun 2011 00:55:04 +0300
Subject: [RFC 1/8] drivers: add generic remoteproc framework
In-Reply-To: <20110627232903.GB7736@n2100.arm.linux.org.uk>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com>
	<1308640714-17961-2-git-send-email-ohad@wizery.com>
	<20110627204958.GB20865@ponder.secretlab.ca>
	<20110627232903.GB7736@n2100.arm.linux.org.uk>
Message-ID: <BANLkTinG=uiUwq4oKGPCX4Phi7gM8NwSQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2011 at 2:29 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> (Don't have the original message to reply to...)

Sorry about that.

My recent emails to linux-arm-kernel were bounced with a "Message has
a suspicious header" reason. not sure what am I doing wrong..

> Do we really want to end up with header being 5 bytes, header_len set
> as 5, and having to load/store all this data using byte loads/stores ?

As Grant said, we're trying to move to ELF now, but if we do end up
sticking with this custom format eventually, we'll sure do take care
of all the alignment issues.

Thanks!

From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 21 Jan 2011 12:59:15 -0500
Subject: [PATCH 0/7] Nexus One Support
In-Reply-To: <1295632569.19880.20.camel@m0nster>
References: <1295555565-21563-1-git-send-email-dwalker@codeaurora.org>
	<AANLkTik+HCj9dkD2s4WgwCqKWCXDbdSnKDUbyGfYfaPr@mail.gmail.com>
	<1295571359.9236.53.camel@m0nster>
	<1295574085.4096.6.camel@Joe-Laptop>
	<1295575123.9236.54.camel@m0nster>
	<1295576730.4096.24.camel@Joe-Laptop>
	<1295624801.19880.13.camel@m0nster>
	<20110121094827.41818a55@jbarnes-desktop>
	<1295632569.19880.20.camel@m0nster>
Message-ID: <20110121175915.GA27611@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 21, 2011 at 09:56:09AM -0800, Daniel Walker wrote:
> I did create these commits. Do you think someone else created the
> commits? There is no commit forwarding happening here.

Creating a commit is easy.  I think for cases like this it's a good
idea to at least write down a "Based on patches from ..." in the
commit message, and preferably also how it relates to their patches.
E.g. dropped android local crap, ported to $FOO kernel ABI, or just
rolled up totally confused local repository history.

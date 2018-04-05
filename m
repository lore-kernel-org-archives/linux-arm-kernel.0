From: broonie@kernel.org (Mark Brown)
Date: Thu, 5 Apr 2018 11:07:40 +0100
Subject: [PATCH v3 3/6] spi: sun6i: restrict transfer length in PIO-mode
In-Reply-To: <20180405091913.ky4dnmszoobn2xry@flea>
References: <20180403154449.2443-1-ssuloev@orpaltech.com>
 <20180403154449.2443-4-ssuloev@orpaltech.com>
 <20180404065048.n76r3ytuznd6fqsl@flea>
 <a6044902-8977-3ce1-d7d5-c6797341a5d0@orpaltech.com>
 <20180405091913.ky4dnmszoobn2xry@flea>
Message-ID: <20180405100740.GA12349@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 05, 2018 at 11:19:13AM +0200, Maxime Ripard wrote:
> On Wed, Apr 04, 2018 at 02:35:14PM +0300, Sergey Suloev wrote:

> > What exactly and in what way ?

> You should explain, at least:
> A) What is the current behaviour
> B) Why that is a problem, or what problem does it cause
> C) What solution you implement and why you think it's justified

Right, this is key - the top level problem with most of this patch set
is that it's hard to understand what the changes are intended to do or
why.  It's really important that people reading the changes be able to
understand what's going on, especially if technical problems have been
found since that tends to make people look more closely.  Part of this
is about splitting the changes out so that each patch does one thing
(which makes it easier to understand them) and part of it is about
explaining those changes clearly.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180405/ff9be1e3/attachment.sig>

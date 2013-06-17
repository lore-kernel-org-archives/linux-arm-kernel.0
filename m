From: henrik@henriknordstrom.net (Henrik =?ISO-8859-1?Q?Nordstr=F6m?=)
Date: Tue, 18 Jun 2013 01:23:35 +0200
Subject: [linux-sunxi] Re: [PATCH 1/2] Initial support for Allwinner's
 Security ID fuses
In-Reply-To: <20130617225847.GA9494@kroah.com>
References: <1371502778-15849-1-git-send-email-oliver+list@schinagl.nl>
 <1371502778-15849-2-git-send-email-oliver+list@schinagl.nl>
 <20130617225847.GA9494@kroah.com>
Message-ID: <1371511415.9185.18.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

m?n 2013-06-17 klockan 15:58 -0700 skrev Greg KH:

> Really?  I don't mind it but is this something that is ok to add to the
> pool?  Will it be different on different machines with this device?  Or
> will it always be the same on all systems with this device?

The data is unique per CPU, so it's different on every machine and is
why it was suggested to have it added to the pool.

Regards
Henrik

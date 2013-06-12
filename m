From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 12 Jun 2013 14:12:00 -0600
Subject: [PATCH 04/14] bus: mvebu-mbus: Add static window allocation to
 the DT binding
In-Reply-To: <20130612200248.GA23012@localhost>
References: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130609014506.GB10027@obsidianresearch.com>
 <20130611135737.GC3996@localhost> <20835253.Agl4DfuI3k@wuerfel>
 <20130611215023.GA12649@obsidianresearch.com>
 <20130612200248.GA23012@localhost>
Message-ID: <20130612201200.GA21103@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 12, 2013 at 05:02:50PM -0300, Ezequiel Garcia wrote:

> I'm probably missing something, but... are you sure that's supposed to work?

Hum.

Looking through the yacc for dtc, it looks like all exprs must be enclosed
in (), so no it shouldn't work, sadly.

Jason

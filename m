From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Mon, 23 Jan 2017 17:56:24 +0100
Subject: [PATCH 10/18] ARM64: dts: meson-gxbb: Reorder nodes
In-Reply-To: <20170123165208.4ujwm6rjz2b3dom5@rob-hp-laptop>
References: <20170120222118.21476-1-afaerber@suse.de>
 <20170120222118.21476-11-afaerber@suse.de>
 <20170123165208.4ujwm6rjz2b3dom5@rob-hp-laptop>
Message-ID: <d58f8343-8369-95ac-3c21-ba8f35e7ac89@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 23.01.2017 um 17:52 schrieb Rob Herring:
> On Fri, Jan 20, 2017 at 11:21:10PM +0100, Andreas F?rber wrote:
>> Sort nodes referenced by label alphabetically.
> 
> Seems to be pointless churn.

We are constantly adding new nodes, so this avoids duplicates, mismerges
and uncertainties of where things should be added. Thought that would be
obvious, as I've been asked to do it elsewhere.

It also helps with diff -u'ing .dts files to see actual differences.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)

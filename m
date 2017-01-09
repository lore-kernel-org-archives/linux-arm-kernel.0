From: ryan@nardis.ca (Ryan Tandy)
Date: Sun, 8 Jan 2017 21:43:15 -0800
Subject: [PATCH v4 1/2] power: reset: add linkstation-reset driver
In-Reply-To: <CAEQ9gEkvj++e7ch40cFqBy3KXg-a=pYnH7cwErMe2RDd2qzQJg@mail.gmail.com>
References: <20161227070611.14852-1-rogershimizu@gmail.com>
 <20170107150451.17912-1-rogershimizu@gmail.com>
 <20170107150451.17912-2-rogershimizu@gmail.com>
 <20170108170209.GD573@kiwi.nardis.ca>
 <CAEQ9gEkvj++e7ch40cFqBy3KXg-a=pYnH7cwErMe2RDd2qzQJg@mail.gmail.com>
Message-ID: <20170109054315.GB580@kiwi.nardis.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2017 at 12:31:44PM +0900, Roger Shimizu wrote:
>This driver, linkstation-reset, can also handle PPC Linkstation after
>it's converted to DT.
>I already considered this and mentioned in previous reply [0].

OK. I was thinking of Sebastian's earlier comment:

On Wed, Dec 21, 2016 at 04:59:29PM +0100, Sebastian Reichel wrote:
>These models can just be added to qnap-poweroff, which handles
>exactly this special case as far as I can see.

and forgot that you planned to handle it in this driver. Sorry for the 
noise.

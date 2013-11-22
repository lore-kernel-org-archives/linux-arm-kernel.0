From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 22 Nov 2013 10:38:00 -0500
Subject: [PATCH] ARM: kirkwood: ReadyNAS Duo v2 .dts cleanup
In-Reply-To: <87li0ge9te.fsf@natisbad.org>
References: <87li0ge9te.fsf@natisbad.org>
Message-ID: <20131122153800.GJ29241@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnaud,

On Fri, Nov 22, 2013 at 04:27:09PM +0100, Arnaud Ebalard wrote:
> The patch does some cleanup work on NETGEAR ReadyNAS Duo v2 .dts
> file. Changes are listed below:

Can you do the whitespace cleanup as a separate patch, and do all your
boards in one go?

>  - Converted GPIO voltage level from value to macros
>  - Converted all numeric input key values to macros
>  - Made button node names more explicit
>  - Added compatible string for PHY (marvell,mv88e1318s)
>  - Added header for the file to describe content and author
>  - Made G762 clock node name unique by including g762 in it
>  - Fixed all node names and labels to use respectively '-' and '_'
>  - Removed useless clocks and gpio-keys properties

First patch

>  - Fixed bad spacing
>  - Added some space between some nodes to improve readability

Second patch, or last in series.

thx,

Jason.

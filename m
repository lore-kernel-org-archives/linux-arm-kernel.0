From: tom.leiming@gmail.com (Ming Lei)
Date: Fri, 16 Dec 2011 23:57:17 +0800
Subject: [QUESTION] How to set static/dynamic dependency between clock
 domains
In-Reply-To: <CACVXFVMe7T2WJiDwc9DFz9ifUPQG4pcYzFtx6O=gs7pFgrkNJg@mail.gmail.com>
References: <CACVXFVMe7T2WJiDwc9DFz9ifUPQG4pcYzFtx6O=gs7pFgrkNJg@mail.gmail.com>
Message-ID: <CACVXFVPOaw7OG7owJw0h7DAe3pRH6nROsy13UeAWPWgLedKY1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Dec 16, 2011 at 9:24 PM, Ming Lei <tom.leiming@gmail.com> wrote:

> Also I have tried to add 'l3_2_clkdm' into dependency table of iss_clkdm in [2],
> and it doesn't work.

Also, I still have the question why the static dependency isn't generated from
the table .wkdep_srcs of struct clockdomain? Seems the static dep info has been
put inside the tables.

thanks,
-- 
Ming Lei

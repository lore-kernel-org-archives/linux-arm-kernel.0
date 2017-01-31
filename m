From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 31 Jan 2017 11:17:15 -0200
Subject: Still having noise issues when recording sound on i.MX28
In-Reply-To: <1485348877.16373.7.camel@embedded.rocks>
References: <1485348877.16373.7.camel@embedded.rocks>
Message-ID: <CAOMZO5AP8HuH7dnfVNW17t2bO4_+h=DGBWZuhVvhu=0a-xAsZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi J?rg,

On Wed, Jan 25, 2017 at 10:54 AM, J?rg Krause
<joerg.krause@embedded.rocks> wrote:

> Is anyone facing the same problem? Has anyone found a solution for this
> using the mainline kernel?

Mainline still has this issue.

It has been fixed on the vendor's kernel tree:
http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/log/?h=imx_2.6.35_maintain

See the last 4 commits.

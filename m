From: zonque@gmail.com (Daniel Mack)
Date: Thu, 01 Mar 2012 16:10:50 +0100
Subject: [PATCH 0/2] mxc_ehci: expand usb_hwinit options from boardfile
In-Reply-To: <3F263ABB4EDE344D974E1983B56807739E4BC6AC@EX-DAG02.eckelmann.group>
References: <3F263ABB4EDE344D974E1983B56807739E4BC6AC@EX-DAG02.eckelmann.group>
Message-ID: <4F4F917A.3040106@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28.02.2012 18:48, Mehnert, Torsten wrote:
> This patch series is about to expand the possibilities to configure mxc USB hardware initialization from boardfile.
> The expansions, defined in mxc_ehci.h, are implemented for the mx25.

FWIW, they both seem reasonable to me. I didn't check the datasheet
though, nor can I test these changes.


Daniel

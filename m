From: lznuaa@gmail.com (Zhi Li)
Date: Wed, 2 Mar 2016 10:44:53 -0600
Subject: [PATCH net-next V2 04/16] net: fec: reduce interrupts
In-Reply-To: <56D710EB.5000201@boundarydevices.com>
References: <1456360619-24390-1-git-send-email-troy.kisky@boundarydevices.com>
 <1456360619-24390-5-git-send-email-troy.kisky@boundarydevices.com>
 <VI1PR0401MB18558A7D0A57FA8EDBAD5EABFFBC0@VI1PR0401MB1855.eurprd04.prod.outlook.com>
 <56D710EB.5000201@boundarydevices.com>
Message-ID: <CAHrpEqR0-POp__KfHUdKVf3kE5H5zHMTYD4j7ADGNZRf9dgfCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 2, 2016 at 10:12 AM, Troy Kisky
<troy.kisky@boundarydevices.com> wrote:
> it is going to be delayed for a very long time.
> Should it be moved to the napi routine?

No!

irq can generate.  Compared irq enable is not controlled by EIMR, but TCSR.

Original code is correct.

best regards
Frank Li

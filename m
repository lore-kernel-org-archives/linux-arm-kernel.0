From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 10 Mar 2017 19:05:02 -0300
Subject: [PATCH v5 07/39] ARM: dts: imx6qdl-sabrelite: remove erratum
 ERR006687 workaround
In-Reply-To: <20170310215731.GB6540@amd>
References: <1489121599-23206-1-git-send-email-steve_longerbeam@mentor.com>
 <1489121599-23206-8-git-send-email-steve_longerbeam@mentor.com>
 <9f5d0ac4-0602-c729-5c00-1d9ef49247c1@boundarydevices.com>
 <CAOMZO5BNrSEyrbWbCBCbsy4yTrh4AHfk2Too0qHuffxqUCgADg@mail.gmail.com>
 <20170310215731.GB6540@amd>
Message-ID: <CAOMZO5DjiJGXXOg2sw79=sO6zvP7iO634AE1Zds=tuWe7jWadg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 10, 2017 at 6:57 PM, Pavel Machek <pavel@ucw.cz> wrote:

> And it should not depend on configuration. Hardware vendor should be
> able to ship board with working device tree...

We are talking about pin conflict here. Please read the commit log of
this patch for details.

From: gnomes@lxorguk.ukuu.org.uk (One Thousand Gnomes)
Date: Fri, 7 Mar 2014 21:29:44 +0000
Subject: [PATCH RFC v2 06/11] tty: xuartps: Change driver name to
 'cdns-uart'
In-Reply-To: <1394219614-3197-7-git-send-email-soren.brinkmann@xilinx.com>
References: <1394219614-3197-1-git-send-email-soren.brinkmann@xilinx.com>
 <1394219614-3197-7-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <20140307212944.4007c6f1@alan.etchedpixels.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri,  7 Mar 2014 11:13:29 -0800
Soren Brinkmann <soren.brinkmann@xilinx.com> wrote:

> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
> I'm not sure about this change. Is this acceptable or already too much?
> I think the name is used for some sysfs entries.

Its probably not a good idea. You might be ok depending whether anything
ever used the sysfs nodes.

Alan

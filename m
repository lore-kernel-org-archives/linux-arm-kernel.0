From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 5 Feb 2013 18:32:21 +0100
Subject: [PATCH v4 3/4] Thermal: Dove: Add Themal sensor support for Dove.
In-Reply-To: <20130205170908.GA2525@localhost>
References: <1359946148.2250.47.camel@rzhang1-mobl4>
 <1360005560-21945-1-git-send-email-andrew@lunn.ch>
 <1360005560-21945-4-git-send-email-andrew@lunn.ch>
 <20130205170908.GA2525@localhost>
Message-ID: <20130205173221.GB20212@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 05, 2013 at 02:09:09PM -0300, Ezequiel Garcia wrote:
> Hi Andrew,
> 
> Nice work!
> 
> Do you also intend to work
> on thermal support for Armada family?

Hi Ezequiel

I don't have enough information about Armada 370/XP to write a driver
for them. Once a datasheet becomes available i will have a go.

Thanks for the comment about kzalloc(). I will remove the dev_err()
call.

    Andrew

From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 17 Nov 2012 09:29:05 +0100
Subject: [PATCH v2 0/3] GPIO driver to turn power off
In-Reply-To: <20121116192335.GA11976@lizard>
References: <1352821485-10032-1-git-send-email-andrew@lunn.ch>
 <20121116141947.GN22106@titan.lakedaemon.net>
 <20121116192335.GA11976@lizard>
Message-ID: <20121117082905.GG24569@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2012 at 11:23:35AM -0800, Anton Vorontsov wrote:
> On Fri, Nov 16, 2012 at 09:19:47AM -0500, Jason Cooper wrote:
> [...]
> > Is it ok if we take this through the arm-soc tree with your Ack?
> 
> Yup. The driver looks good.
> 
> Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

Hi Anton

Thanks for the ACK.

I will respin another version, with the delay before WARN() increased,
and fix the polarity of the GPIO i got wrong.

    Andrew

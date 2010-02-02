From: epeer@tmtservices.co.za (Edwin Peer)
Date: Tue, 2 Feb 2010 08:14:08 +0200
Subject: [PATCH - v5] support for Embedian MXM-8x10
In-Reply-To: <f17812d71002011242i53f4c2faoe47b3d6988cefaa@mail.gmail.com>
References: <201001221010.45174.epeer@tmtservices.co.za>
	<f17812d71002011242i53f4c2faoe47b3d6988cefaa@mail.gmail.com>
Message-ID: <201002020814.08656.epeer@tmtservices.co.za>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 01 February 2010 22:42:00 Eric Miao wrote:

> > +static struct spi_board_info mcp251x_board_info[] = {
> > +       {
> > +               .modalias        = "mcp251x",
> > +               .max_speed_hz    = 65E5,
> 
> This looks weird to me, should be an integer here right?

Correct. That's 65 x 10^5, or equivalently 6.5 x 10^6. Would you prefer the 
patch to have it in decimal?

Regards,
Edwin Peer

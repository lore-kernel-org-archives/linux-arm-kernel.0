From: jassisinghbrar@gmail.com (jassi brar)
Date: Mon, 15 Mar 2010 18:37:59 +0900
Subject: QUERY: How to handle SOC Configuration (Peripheral Multiplexing)
	in linux
In-Reply-To: <4B9DF966.6050504@st.com>
References: <4B9DB823.1040809@st.com>
	<20100315062041.GD31126@trinity.fluff.org> <4B9DD3A3.7050106@st.com>
	<4B9DF2FF.3000706@st.com> <4B9DF966.6050504@st.com>
Message-ID: <1b68c6791003150237k3d1508d3meb8370509dcfc9a8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 15, 2010 at 6:09 PM, Shiraz HASHIM <shiraz.hashim@st.com> wrote:
> yes, and if you see, should any one require it dynamically? Each user
> would have his own board with static devices. This configuration (of
> selecting multiplexed devices) depends on his board configuration, which
> is the responsibility of the board configuration file.
sorry for barging in but ...
usually device makers(that release product versions with same SoC but
different devices)
want a single kernel image that detects the machine type and
accordingly populate the
device support. Managing separate images for similar devices is
considered inefficient.

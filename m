From: shiraz.hashim@st.com (Shiraz HASHIM)
Date: Mon, 15 Mar 2010 15:52:29 +0530
Subject: QUERY: How to handle SOC Configuration (Peripheral Multiplexing)
	in linux
In-Reply-To: <1b68c6791003150237k3d1508d3meb8370509dcfc9a8@mail.gmail.com>
References: <4B9DB823.1040809@st.com>	
	<20100315062041.GD31126@trinity.fluff.org>
	<4B9DD3A3.7050106@st.com>	 <4B9DF2FF.3000706@st.com>
	<4B9DF966.6050504@st.com>
	<1b68c6791003150237k3d1508d3meb8370509dcfc9a8@mail.gmail.com>
Message-ID: <4B9E0A65.2090103@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jassi,

On 3/15/2010 3:07 PM, jassi brar wrote:
> On Mon, Mar 15, 2010 at 6:09 PM, Shiraz HASHIM <shiraz.hashim@st.com> wrote:
>> > yes, and if you see, should any one require it dynamically? Each user
>> > would have his own board with static devices. This configuration (of
>> > selecting multiplexed devices) depends on his board configuration, which
>> > is the responsibility of the board configuration file.
> sorry for barging in but ...

your comments are most welcome.

> usually device makers(that release product versions with same SoC but
> different devices)
> want a single kernel image that detects the machine type and
> accordingly populate the
> device support. Managing separate images for similar devices is
> considered inefficient.

Actually you have pointed to right thing and this is really important.
Some architectures (I think ppc) have device tree option to pass the
hardware configuration to the kernel from bootloader.
I dont know such option exists for arm. Lets hear others' opinions.

Following link exactly targets this
http://ols.fedoraproject.org/OLS/Reprints-2008/likely2-reprint.pdf

regards
Shiraz

 

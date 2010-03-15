From: jassisinghbrar@gmail.com (jassi brar)
Date: Mon, 15 Mar 2010 19:34:57 +0900
Subject: QUERY: How to handle SOC Configuration (Peripheral Multiplexing)
	in linux
In-Reply-To: <4B9E0A65.2090103@st.com>
References: <4B9DB823.1040809@st.com>
	<20100315062041.GD31126@trinity.fluff.org> <4B9DD3A3.7050106@st.com>
	<4B9DF2FF.3000706@st.com> <4B9DF966.6050504@st.com>
	<1b68c6791003150237k3d1508d3meb8370509dcfc9a8@mail.gmail.com>
	<4B9E0A65.2090103@st.com>
Message-ID: <1b68c6791003150334i5f603a48xd363a64e08bf2113@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 15, 2010 at 7:22 PM, Shiraz HASHIM <shiraz.hashim@st.com> wrote:
>> usually device makers(that release product versions with same SoC but
>> different devices)
>> want a single kernel image that detects the machine type and
>> accordingly populate the
>> device support. Managing separate images for similar devices is
>> considered inefficient.
>
> Actually you have pointed to right thing and this is really important.
> Some architectures (I think ppc) have device tree option to pass the
> hardware configuration to the kernel from bootloader.
> I dont know such option exists for arm. Lets hear others' opinions.
I don't think you can't do without device-trees.

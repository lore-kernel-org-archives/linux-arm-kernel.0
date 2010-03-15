From: armando.visconti@st.com (Armando VISCONTI)
Date: Mon, 15 Mar 2010 09:42:39 +0100
Subject: QUERY: How to handle SOC Configuration (Peripheral	Multiplexing)
	in linux
In-Reply-To: <4B9DD3A3.7050106@st.com>
References: <4B9DB823.1040809@st.com>
	<20100315062041.GD31126@trinity.fluff.org>
	<4B9DD3A3.7050106@st.com>
Message-ID: <4B9DF2FF.3000706@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Viresh,

> Now, For this we need some interface or channel through which we provide
> this information to kernel. This is what precisely i have done. The channel i
> provided is through Kconfig and the function "s300_configure", accepts this 
> bitmap and configures hardware.
>   
I'm not getting this point.

If you do it thru Kconfig still it would be fixed a compilation time.
Do you agree or am I missing something?

So, probably the correct way is passing peripheral selection information 
thru
bootargs.
What do you think?

Armando

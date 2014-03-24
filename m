From: srinivas.kandagatla@st.com (srinivas kandagatla)
Date: Mon, 24 Mar 2014 09:15:39 +0000
Subject: stmmac-socfpga breakage in arm-soc
In-Reply-To: <4171731.dt8xNWCpb2@wuerfel>
References: <201403191333.01095.arnd@arndb.de> <4337501.shzGE38xmF@wuerfel>
 <5329A7A1.20606@gmail.com> <4171731.dt8xNWCpb2@wuerfel>
Message-ID: <532FF7BB.5020003@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/03/14 15:07, Arnd Bergmann wrote:
> Ok, so the two of you basically moved in opposite directions where
> Srinivas started out with the method you ended up with and vice versa.
Yes thats correct, While adding dwmac-sunxi.c we decided to go with
callback methods given its flexibility for calling at runtime(example:
when link speed changes).


--srini

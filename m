From: stefan@agner.ch (Stefan Agner)
Date: Sun, 03 Jul 2016 11:25:57 -0700
Subject: [PATCH v2] clk: imx7d: do not set parent of ethernet time/ref
 clocks
In-Reply-To: <CAOMZO5AghMZ0iV0=0hBrFhhhAAfPpyxH0oj8UT7TqZr9N0+y9A@mail.gmail.com>
References: <20160703174813.13970-1-stefan@agner.ch>
 <CAOMZO5AghMZ0iV0=0hBrFhhhAAfPpyxH0oj8UT7TqZr9N0+y9A@mail.gmail.com>
Message-ID: <d5ff8c157bf6108afe2b14ae887c7b71@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-07-03 11:23, Fabio Estevam wrote:
> Hi Stefan,
> 
> On Sun, Jul 3, 2016 at 2:48 PM, Stefan Agner <stefan@agner.ch> wrote:
> 
>> Fabio, thanks for testing v1.
>>
>> With v2, the warnings should definitly be gone. However, that might
>> break some boards...
> 
> Still see the warnings with v2.

Hm, just checked again, that is really not the case here. On what base
do you test? I tested on clk-next. Dong's clock changes are a
prerequisite for that.

What U-Boot version do you use?

I tested on Colibri iMX7 here, but that early during boot there
shouldn't be a difference.

--
Stefan

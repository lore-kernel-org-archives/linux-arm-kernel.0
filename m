From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 25 Jul 2012 07:33:52 -0300
Subject: [PATCH] ARM: mxs: Adjust of_find_property()
In-Reply-To: <20120725095218.5952d1a888bbc1337d4e73bc@kinali.ch>
References: <1343028538-13891-1-git-send-email-festevam@gmail.com>
 <20120725095218.5952d1a888bbc1337d4e73bc@kinali.ch>
Message-ID: <CAOMZO5C6poKx=hmJ7DEzqZyFFZ3ZmJ5pdJQGNWJfin9DF4ySSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 25, 2012 at 4:52 AM, Attila Kinali <attila@kinali.ch> wrote:
> On Mon, 23 Jul 2012 04:28:58 -0300
> Fabio Estevam <festevam@gmail.com> wrote:
>
>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>
>> Since commit 475d00 (of: Improve prom_update_property() function) prom_update_property requires
>> two arguments.
>>
>> Fix this in order to get rid of the following build error:
>>
>> arch/arm/mach-mxs/mach-mxs.c:175:4: error: too many arguments to function 'prom_update_property'
>
> The same fix has been already send by Shawn Guo[1] and Lauri Hintsala[2]

Couldn't one of this  patch be applied then?

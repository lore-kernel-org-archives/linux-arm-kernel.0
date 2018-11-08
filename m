From: dinguyen@kernel.org (Dinh Nguyen)
Date: Thu, 8 Nov 2018 09:38:38 -0600
Subject: [PATCH v2 1/3] ARM: socfpga: Clean unused functions
In-Reply-To: <CAJiuCcdKFKmwB5mqW-bP+4A4HtVr=1z9avxoDPrD3NL9X9i8MQ@mail.gmail.com>
References: <20181009112021.756-1-peron.clem@gmail.com>
 <CAJiuCceqyPY+dYr+1xdSyUh5x1Fr=M_p1nsMF9h52v5CXt1uYw@mail.gmail.com>
 <20181023085208.GL30658@n2100.armlinux.org.uk>
 <CAJiuCcdKFKmwB5mqW-bP+4A4HtVr=1z9avxoDPrD3NL9X9i8MQ@mail.gmail.com>
Message-ID: <27e04998-8e67-e543-d717-2ac7e47b1732@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Cl?ment,

On 11/2/18 10:58 AM, Cl?ment P?ron wrote:
> Hi Dinh,
> 
> Could you have a look at this serie ?
> 

I've applied 1/3 and 3/3. I need to look over 2/3 to determine if that
patch is still valid. I think a better solution would be to set a clock
as critical so that it doesn't get gated.

Thanks,
Dinh

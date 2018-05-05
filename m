From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 5 May 2018 11:49:23 +0300
Subject: [PATCH v9 01/12] ARM: Allow this header to be included by
 assembly files
In-Reply-To: <20180504190545.5114-2-mylene.josserand@bootlin.com>
References: <20180504190545.5114-1-mylene.josserand@bootlin.com>
 <20180504190545.5114-2-mylene.josserand@bootlin.com>
Message-ID: <60ba513e-d865-d4c0-7956-7d6302020165@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

On 5/4/2018 10:05 PM, Myl?ne Josserand wrote:

> From: Doug Berger <opendmb@gmail.com>
> 
> The constants defined in this file are equally useful in assembly and C
> source files. The arm64 architecture version of this file allows
> inclusion in both assembly and C source files, so this this commit adds

    One "this" is enough. :-)

> that capability to the arm architecture version so that the constants
> don't need to be defined in multiple places.
> 
> Signed-off-by: Doug Berger <opendmb@gmail.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Myl?ne Josserand <mylene.josserand@bootlin.com>
[...]

MBR, Sergei

From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 16 Apr 2018 15:17:13 -0700
Subject: [PATCH 1/4] ARM: Allow this header to be included by assembly
 files
In-Reply-To: <20180223210923.544-2-f.fainelli@gmail.com>
References: <20180223210923.544-1-f.fainelli@gmail.com>
 <20180223210923.544-2-f.fainelli@gmail.com>
Message-ID: <20180416221713.31685-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 23 Feb 2018 13:09:20 -0800, Florian Fainelli <f.fainelli@gmail.com> wrote:
> From: Doug Berger <opendmb@gmail.com>
> 
> The constants defined in this file are equally useful in assembly and C
> source files. The arm64 architecture version of this file allows
> inclusion in both assembly and C source files, so this this commit adds
> that capability to the arm architecture version so that the constants
> don't need to be defined in multiple places.
> 
> Signed-off-by: Doug Berger <opendmb@gmail.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied to soc/next, thanks!
--
Florian

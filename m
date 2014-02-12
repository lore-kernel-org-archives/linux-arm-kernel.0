From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 12 Feb 2014 13:18:34 +0000
Subject: [PATCH v2] ARM: Add imprecise abort enable/disable macro
In-Reply-To: <52FB71A3.5010505@stericsson.com>
References: <1392050756-11145-1-git-send-email-fabrice.gasnier@st.com>
 <52FB71A3.5010505@stericsson.com>
Message-ID: <20140212131834.GP26684@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 12, 2014 at 02:05:39PM +0100, Fabrice GASNIER wrote:
> Hi,
>
> Any comments on this patch ?
>
> Russell, can I add this patch to your patch tracker system ?

I don't see how this works on anything but ARMv7M.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".

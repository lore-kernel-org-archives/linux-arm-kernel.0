From: viresh.kumar@st.com (Viresh KUMAR)
Date: Thu, 25 Mar 2010 13:32:59 +0530
Subject: [PATCH V2 00/12] Adding Support for SPEAr Platform under ARM
	architecture
In-Reply-To: <1269502028-12867-1-git-send-email-viresh.kumar@st.com>
References: <1269502028-12867-1-git-send-email-viresh.kumar@st.com>
Message-ID: <4BAB18B3.6050800@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/25/2010 12:56 PM, Viresh KUMAR wrote:
> Following set of patches are for adding ST Microelctronics SPEAr Platform under
> ARM architecture in Linux.
> 
> Hierarchy in SPEAr is as follows:
> SPEAr (Platform)
> 	- SPEAr3XX (3XX SOC series, based on ARM9)
> 		- SPEAr300 (SOC)
> 			- SPEAr300_EVB (Evaluation Board)
> 		- SPEAr310 (SOC)
> 			- SPEAr310_EVB (Evaluation Board)
> 		- SPEAr320 (SOC)
> 			- SPEAr320_EVB (Evaluation Board)
> 	- SPEAr6XX (6XX SOC series, based on ARM9)
> 		- SPEAr600 (SOC)
> 			- SPEAr600_EVB (Evaluation Board)
> 	- SPEAr13XX (13XX SOC series, based on ARM CORTEXA9)
> 		- SPEAr1300 (SOC)
> 
> Current patch will add support for SPEAr3XX and SPEAr6XX family. SPEAr13XX is
> under development phase.
> 
> Changes from V1:
> 
> 1. Changes done according to review comments
> 2. Added support for GPIO PL061
> 3. Removed unnecessary inclusions from defconfigs
> 4. Removed GPT driver. GPT code merged with time.c
> 5. Added support for pad multiplexing for spear
> 

Sorry. Please don't review this patch set. Something wrong
happened in PATCH V2 09/12. I will send patch set again after correction.

regards,
viresh kumar.

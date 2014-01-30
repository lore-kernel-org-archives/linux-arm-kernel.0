From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 30 Jan 2014 14:02:01 +0100
Subject: [PATCH V3 3/8] SPEAr13xx: defconfig: Update
In-Reply-To: <77553346b18c3978b12329161a85dba7d50242ca.1391077731.git.mohit.kumar@st.com>
References: <cover.1391077731.git.mohit.kumar@st.com>
 <77553346b18c3978b12329161a85dba7d50242ca.1391077731.git.mohit.kumar@st.com>
Message-ID: <201401301402.01842.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 30 January 2014, Mohit Kumar wrote:
> Enable EABI, OEABI, VFP and NFS configs in default configuration file for
> SPEAr13xx.

Are you sure about OABI_COMPAT? That seems unusual.

Also, please add all the options you need to multi_v7_defconfig
and ensure that this configuration works with your hardware as well.

	Arnd

From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 23 Jan 2014 13:12:15 +0100
Subject: [PATCH V2 6/8] SPEAr13xx: Fix static mapping table
In-Reply-To: <22d2e7d6fbd5a291cdecf6a4d1e294d9c9ede617.1390471111.git.mohit.kumar@st.com>
References: <cover.1390471111.git.mohit.kumar@st.com>
 <22d2e7d6fbd5a291cdecf6a4d1e294d9c9ede617.1390471111.git.mohit.kumar@st.com>
Message-ID: <201401231312.15885.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 23 January 2014, Mohit Kumar wrote:
> From: Pratyush Anand <pratyush.anand@st.com>
> 
> SPEAr13xx was using virtual address space 0xFE000000 to map physical address
> space 0xB3000000. pci_remap_io uses 0xFEE00000 as virtual address. So
> change 0xFE000000 to 0xF9000000.
> 
> Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
> Tested-by: Mohit Kumar <mohit.kumar@st.com>
> Cc: Viresh Kumar <viresh.linux@gmail.com>
> Cc: spear-devel at list.st.com
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Arnd Bergmann <arnd@arndb.de>

Surely this is needed in backports, so please add stable at vger.kernel.org
to the Cc list in the changeset text. Otherwise

Acked-by: Arnd Bergmann <arnd@arndb.de>

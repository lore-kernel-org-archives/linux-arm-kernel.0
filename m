From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 27 May 2011 09:24:00 +0200
Subject: [RFC] ARM Subarchitecture group maintainership
In-Reply-To: <4DDF37DB.40606@st.com>
References: <201105181047.17309.arnd@arndb.de>
	<201105191550.20129.arnd@arndb.de> <4DDF37DB.40606@st.com>
Message-ID: <201105270924.00881.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 27 May 2011, viresh kumar wrote:
> We also have few patchsets for ST's SPEAr SOC family. They were already
> reviewed, but never got pushed.
> 
> We will update all those pacthsets for point 2 & 3, and leave point 1 for now.
> Also we will update them with our latest changes for SPEAr and will circulate
> them ASAP.
> 
> Hope that's fine.

Sure, please do. Once we look at the patch sets, we can also discuss about
how and when to change them over to device tree. Since the spear13xx patches
you posted only have support for a single board, it should be fairly easy
to replace the board file with a generic device tree based one.

	Arnd

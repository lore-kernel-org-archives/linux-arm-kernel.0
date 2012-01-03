From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 3 Jan 2012 09:46:42 -0800
Subject: [PATCH v3] Input: keyboard - add device tree bindings for
 simple key matrixes
In-Reply-To: <1325484557-27695-1-git-send-email-olof@lixom.net>
References: <1325184146-3527-1-git-send-email-olof@lixom.net>
 <1325484557-27695-1-git-send-email-olof@lixom.net>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17761F10DC@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote at Sunday, January 01, 2012 11:09 PM:
> This adds a simple device tree binding for simple key matrix data and
> a helper to fill in the platform data.
> 
> The implementation is in a shared file outside if drivers/input/keyboard
> since some drivers in drivers/input/misc might be making use of it
> as well.
> 
> Changes since v2:
>  * Removed reference to "legacy" format with a subnode per key
>  * Changed to a packed format with one cell per key instead of 3.
>  * Moved new OF helper to separate file
>  * Misc fixups based on comments
> 
> Changes since v1:
>  * Removed samsung-style binding support
>  * Added linux,fn-keymap and linux,fn-key optional properties
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>

Acked-by: Stephen Warren <swarren@nvidia.com>

The new binding looks good to me. I assume the FIXME in the code was
deliberate.

-- 
nvpublic

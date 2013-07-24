From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 24 Jul 2013 13:20:33 +0200
Subject: [PATCH v8 06/28] ARM: dove: Move to ID based window creation
In-Reply-To: <1374586292-4941-7-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1374586292-4941-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1374586292-4941-7-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <51EFB881.4030901@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/23/13 15:31, Ezequiel Garcia wrote:
> From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>
> With the introduction of the ID based MBus API, it's better
> to switch to use it instead of the current name based scheme.
>
> This will allow to deprecate the name based API, once every
> user is removed.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>   arch/arm/mach-dove/common.c | 68 ++++++++++++++++++++++++++++++---------------
>   1 file changed, 45 insertions(+), 23 deletions(-)

Ezequiel,

for the whole patch series on Dove DT:

Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Sebastian

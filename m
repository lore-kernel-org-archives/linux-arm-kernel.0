From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 14 Jul 2015 13:59:10 -0300
Subject: mx6: suspicious RCU usage
In-Reply-To: <CAOMZO5AcegpqyDtsyawbSCDZcFnpHjq7uxRQJxBiFjzMH0hyDA@mail.gmail.com>
References: <CAOMZO5DeOLORXUAgYN2_BkB1BS8wuF8CoTf=QOfU1fB-je0UHQ@mail.gmail.com>
 <20150714160006.GI3717@linux.vnet.ibm.com>
 <CAOMZO5Bbj2FjWxNGDUHSHXCPFC1A7F6sO6AepZjRZoxHY-kgYg@mail.gmail.com>
 <20150714162600.GJ3717@linux.vnet.ibm.com>
 <CAOMZO5AcegpqyDtsyawbSCDZcFnpHjq7uxRQJxBiFjzMH0hyDA@mail.gmail.com>
Message-ID: <CAOMZO5C1+qQyFqfrfWatsY_yjO952gk1o9qmJJgMmjDEAix21g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 14, 2015 at 1:44 PM, Fabio Estevam <festevam@gmail.com> wrote:

> With your patch applied I am running several suspend/resume cycles and
> I am seeing different problems now from time to time (like 1 out 10
> times). The kernel dump does not look like the same every time, but
> here is one example:

Here is another one I just got, and it seems to be more informative:

http://pastebin.com/T4YxuLCg

Thanks

From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Sat, 11 Oct 2014 14:27:36 -0500
Subject: RCU bug with v3.17-rc3 ?
In-Reply-To: <54388B81.5020306@mentor.com>
References: <20140905213216.GD5001@linux.vnet.ibm.com>
 <20141008171322.GH22688@saruman> <20141008175707.GI22688@saruman>
 <20141008212938.GP22688@saruman> <20141009160138.GA2396@cmpxchg.org>
 <20141009162656.GE16002@saruman> <20141009204101.GA25955@debian>
 <20141009204637.GE25729@saruman> <20141009210715.GH25729@saruman>
 <20141010135743.GB31348@saruman>
 <20141010162531.GL12379@n2100.arm.linux.org.uk> <54388B81.5020306@mentor.com>
Message-ID: <543984A8.8050701@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/10/2014 08:44 PM, Nathan Lynch wrote:
> On 10/10/2014 11:25 AM, Russell King - ARM Linux wrote:
>>
>> Right, so GCC 4.8.{1,2} are totally unsuitable for kernel building (and
>> it seems that this has been known about for some time.)
> 
> Looking at http://gcc.gnu.org/PR58854 it seems that all 4.8.x for x < 3
> are affected, as well as 4.9.0.

Correction -- 4.9.0 has this fixed, even though the GCC PR shows it as a
"known to fail" version.

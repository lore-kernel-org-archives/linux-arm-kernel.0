From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Wed, 15 Jan 2014 18:16:13 +0100
Subject: [PATCH 3/7] iommu/omap: Convert to devicetree
In-Reply-To: <20140102010150.GA9933@earth.universe>
References: <1387284818-28739-1-git-send-email-florian.vaussard@epfl.ch>
 <1387284818-28739-4-git-send-email-florian.vaussard@epfl.ch>
 <1764051.JiGg1d3s1L@avalon> <20140102010150.GA9933@earth.universe>
Message-ID: <52D6C25D.8050005@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 01/02/2014 02:01 AM, Sebastian Reichel wrote:
> Hi,
> 
> On Thu, Jan 02, 2014 at 01:13:42AM +0100, Laurent Pinchart wrote:
>>> +		.of_match_table = omap_iommu_of_match,
>>
>> If CONFIG_OF isn't defined (pretty unlikely I agree, but a possibility you 
>> seem to be prepared for nonetheless given the above #if), this will fail to 
>> compile.
> 
> FYI: This is avoided in other drivers by using
> of_match_ptr(omap_iommu_of_match), which is replaced with NULL by
> the preprocessor if CONFIG_OF is not defined.
> 

Thank you for the hint.

Florian
